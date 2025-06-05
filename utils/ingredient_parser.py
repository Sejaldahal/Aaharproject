#ingredinet_parser.py
import re
import json
import os
from typing import Dict, List, Set, Tuple
import logging

logger = logging.getLogger(__name__)

class IngredientParser:
    """Parse and analyze food ingredients for diet types and allergens"""
    
    def __init__(self, allergens_data_path: str = None):
        self.allergens_data = self._load_allergens_data(allergens_data_path)
        self.confidence_threshold = 0.7
        
    def _load_allergens_data(self, data_path: str = None) -> Dict:
        """Load allergen data from JSON file or use defaults"""
        if data_path and os.path.exists(data_path):
            try:
                with open(data_path, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except Exception as e:
                logger.warning(f"Could not load allergens data: {e}")
        
        # Return default allergen patterns if file not found
        return {
            'allergens': {
                'nuts': {
                    'keywords': ['almond', 'walnut', 'pecan', 'cashew', 'pistachio', 'hazelnut', 
                                'brazil nut', 'macadamia', 'pine nut', 'tree nuts', 'nuts', 'groundnut', 'peanut'],
                    'severity': 'high',
                    'description': 'Tree nuts and peanuts'
                },
                'dairy': {
                    'keywords': ['milk', 'butter', 'cheese', 'cream', 'yogurt', 'yoghurt', 'whey', 
                                'casein', 'lactose', 'dairy', 'buttermilk', 'ghee', 'paneer', 'curd'],
                    'severity': 'medium',
                    'description': 'Milk and dairy products'
                },
                'gluten': {
                    'keywords': ['wheat', 'barley', 'rye', 'oats', 'gluten', 'flour', 'malt', 
                                'semolina', 'bulgur', 'spelt', 'wheat flour', 'refined flour'],
                    'severity': 'high',
                    'description': 'Gluten-containing grains'
                },
                'soy': {
                    'keywords': ['soy', 'soybean', 'tofu', 'tempeh', 'miso', 'edamame', 'soya'],
                    'severity': 'medium',
                    'description': 'Soy and soy products'
                },
                'eggs': {
                    'keywords': ['egg', 'albumin', 'lecithin', 'mayonnaise', 'egg white', 'egg yolk'],
                    'severity': 'medium',
                    'description': 'Eggs and egg products'
                },
                'fish': {
                    'keywords': ['fish', 'salmon', 'tuna', 'cod', 'sardine', 'anchovy', 'mackerel'],
                    'severity': 'high',
                    'description': 'Fish and fish products'
                },
                'shellfish': {
                    'keywords': ['shrimp', 'crab', 'lobster', 'clam', 'oyster', 'mussel', 'prawn'],
                    'severity': 'high',
                    'description': 'Shellfish and crustaceans'
                },
                'sesame': {
                    'keywords': ['sesame', 'tahini', 'sesame oil', 'sesame seeds'],
                    'severity': 'medium',
                    'description': 'Sesame seeds and products'
                }
            },
            'diet_markers': {
                'non_vegetarian': [
                    'chicken', 'beef', 'pork', 'lamb', 'fish', 'meat', 'gelatin', 'lard',
                    'bacon', 'ham', 'pepperoni', 'sausage', 'turkey', 'duck', 'mutton',
                    'prawn', 'shrimp', 'crab', 'lobster', 'anchovies', 'tuna', 'salmon',
                    'cod', 'sardine', 'mackerel', 'chicken fat', 'beef fat', 'pork fat'
                ],
                'non_vegan': [
                    'milk', 'butter', 'cheese', 'cream', 'yogurt', 'whey', 'casein',
                    'egg', 'honey', 'beeswax', 'albumin', 'ghee', 'paneer', 'curd',
                    'milk powder', 'buttermilk', 'yoghurt', 'dairy'
                ]
            }
        }
    
    def clean_ingredients_text(self, ingredients_text: str) -> str:
        """Clean and normalize ingredients text"""
        if not ingredients_text:
            return ""
        
        # Convert to lowercase
        text = ingredients_text.lower()
        
        # Remove common prefixes and suffixes
        text = re.sub(r'\bingredients?\s*:', '', text)
        text = re.sub(r'\bcontains?\s*:', '', text)
        
        # Remove percentages in parentheses
        text = re.sub(r'\([^)]*%[^)]*\)', '', text)
        
        # Remove extra whitespace
        text = ' '.join(text.split())
        
        return text
    
    def extract_individual_ingredients(self, ingredients_text: str) -> List[str]:
        """Extract individual ingredients from text"""
        if not ingredients_text:
            return []
        
        cleaned_text = self.clean_ingredients_text(ingredients_text)
        
        # Split by common separators
        ingredients = re.split(r'[,;]', cleaned_text)
        
        # Clean each ingredient
        cleaned_ingredients = []
        for ingredient in ingredients:
            ingredient = ingredient.strip()
            # Remove leading numbers and dots
            ingredient = re.sub(r'^\d+\.?\s*', '', ingredient)
            # Remove parenthetical information
            ingredient = re.sub(r'\([^)]*\)', '', ingredient)
            ingredient = ingredient.strip()
            
            if ingredient and len(ingredient) > 1:
                cleaned_ingredients.append(ingredient)
        
        return cleaned_ingredients
    
    def detect_allergens(self, ingredients_text: str) -> Dict[str, any]:
        """Detect allergens in ingredients text"""
        if not ingredients_text:
            return {
                'detected_allergens': [],
                'allergen_details': {},
                'confidence_score': 0.0,
                'severity_level': 'none'
            }
        
        cleaned_text = self.clean_ingredients_text(ingredients_text)
        detected_allergens = {}
        max_severity = 'none'
        
        for allergen_type, allergen_info in self.allergens_data['allergens'].items():
            found_keywords = []
            
            for keyword in allergen_info['keywords']:
                # Use word boundary matching for better accuracy
                pattern = r'\b' + re.escape(keyword) + r'\b'
                if re.search(pattern, cleaned_text):
                    found_keywords.append(keyword)
            
            if found_keywords:
                detected_allergens[allergen_type] = {
                    'found_keywords': found_keywords,
                    'severity': allergen_info['severity'],
                    'description': allergen_info['description'],
                    'confidence': min(1.0, len(found_keywords) * 0.3 + 0.4)
                }
                
                # Update max severity
                if allergen_info['severity'] == 'high':
                    max_severity = 'high'
                elif allergen_info['severity'] == 'medium' and max_severity != 'high':
                    max_severity = 'medium'
                elif max_severity == 'none':
                    max_severity = 'low'
        
        # Calculate overall confidence
        if detected_allergens:
            confidence_score = sum(info['confidence'] for info in detected_allergens.values()) / len(detected_allergens)
        else:
            confidence_score = 0.8  # High confidence in no allergens found
        
        return {
            'detected_allergens': list(detected_allergens.keys()),
            'allergen_details': detected_allergens,
            'confidence_score': min(1.0, confidence_score),
            'severity_level': max_severity,
            'allergen_count': len(detected_allergens)
        }
    
    def determine_diet_type(self, ingredients_text: str) -> Dict[str, any]:
        """Determine diet type (vegan, vegetarian, non-vegetarian)"""
        if not ingredients_text:
            return {
                'diet_type': 'unknown',
                'is_vegan': None,
                'is_vegetarian': None,
                'confidence_score': 0.0,
                'detected_non_veg': [],
                'detected_non_vegan': []
            }
        
        cleaned_text = self.clean_ingredients_text(ingredients_text)
        
        # Check for non-vegetarian ingredients
        detected_non_veg = []
        for ingredient in self.allergens_data['diet_markers']['non_vegetarian']:
            pattern = r'\b' + re.escape(ingredient) + r'\b'
            if re.search(pattern, cleaned_text):
                detected_non_veg.append(ingredient)
        
        # Check for non-vegan ingredients (excluding non-veg ones already found)
        detected_non_vegan = []
        if not detected_non_veg:  # Only check if no non-veg ingredients found
            for ingredient in self.allergens_data['diet_markers']['non_vegan']:
                pattern = r'\b' + re.escape(ingredient) + r'\b'
                if re.search(pattern, cleaned_text):
                    detected_non_vegan.append(ingredient)
        
        # Determine diet type
        if detected_non_veg:
            diet_type = 'non-vegetarian'
            is_vegetarian = False
            is_vegan = False
        elif detected_non_vegan:
            diet_type = 'vegetarian'
            is_vegetarian = True
            is_vegan = False
        else:
            diet_type = 'vegan'
            is_vegetarian = True
            is_vegan = True
        
        # Calculate confidence based on ingredient text length and specificity
        confidence_score = 0.6
        if len(cleaned_text) > 100:
            confidence_score += 0.2
        if detected_non_veg or detected_non_vegan:
            confidence_score += 0.1
        
        return {
            'diet_type': diet_type,
            'is_vegan': is_vegan,
            'is_vegetarian': is_vegetarian,
            'confidence_score': min(1.0, confidence_score),
            'detected_non_veg': detected_non_veg,
            'detected_non_vegan': detected_non_vegan
        }
    
    def analyze_processing_level(self, ingredients_list: List[str]) -> Dict[str, any]:
        """Analyze food processing level based on ingredients"""
        if not ingredients_list:
            return {
                'processing_level': 'unknown',
                'artificial_additives': [],
                'preservatives': [],
                'score': 0
            }
        
        # Common artificial additives and preservatives
        artificial_additives = [
            'artificial flavor', 'artificial flavoring', 'artificial color',
            'artificial coloring', 'msg', 'monosodium glutamate',
            'high fructose corn syrup', 'corn syrup', 'aspartame',
            'sucralose', 'acesulfame', 'sodium benzoate'
        ]
        
        preservatives = [
            'sodium benzoate', 'potassium sorbate', 'calcium propionate',
            'sodium nitrite', 'sodium nitrate', 'bht', 'bha',
            'tbhq', 'sulfur dioxide', 'sodium sulfite'
        ]
        
        ingredients_text = ' '.join(ingredients_list).lower()
        
        found_additives = []
        found_preservatives = []
        
        for additive in artificial_additives:
            if additive in ingredients_text:
                found_additives.append(additive)
        
        for preservative in preservatives:
            if preservative in ingredients_text:
                found_preservatives.append(preservative)
        
        # Calculate processing score (lower is better)
        score = len(found_additives) * 2 + len(found_preservatives) * 1.5
        
        # Determine processing level
        if score >= 10:
            processing_level = 'highly_processed'
        elif score >= 5:
            processing_level = 'moderately_processed'
        elif score >= 2:
            processing_level = 'lightly_processed'
        else:
            processing_level = 'minimally_processed'
        
        return {
            'processing_level': processing_level,
            'artificial_additives': found_additives,
            'preservatives': found_preservatives,
            'processing_score': score,
            'total_additives': len(found_additives) + len(found_preservatives)
        }
    
    def get_ingredient_categories(self, ingredients_list: List[str]) -> Dict[str, List[str]]:
        """Categorize ingredients by type"""
        categories = {
            'proteins': [],
            'carbohydrates': [],
            'fats': [],
            'vitamins_minerals': [],
            'additives': [],
            'natural': [],
            'unknown': []
        }
        
        # Define category patterns
        category_patterns = {
            'proteins': ['protein', 'amino acid', 'meat', 'fish', 'egg', 'milk', 'cheese'],
            'carbohydrates': ['sugar', 'starch', 'flour', 'rice', 'wheat', 'corn', 'glucose'],
            'fats': ['oil', 'fat', 'butter', 'margarine', 'shortening'],
            'vitamins_minerals': ['vitamin', 'mineral', 'calcium', 'iron', 'zinc', 'magnesium'],
            'additives': ['artificial', 'preservative', 'flavor', 'color', 'emulsifier']
        }
        
        for ingredient in ingredients_list:
            ingredient_lower = ingredient.lower()
            categorized = False
            
            for category, patterns in category_patterns.items():
                for pattern in patterns:
                    if pattern in ingredient_lower:
                        categories[category].append(ingredient)
                        categorized = True
                        break
                if categorized:
                    break
            
            if not categorized:
                # Simple heuristic: if it's a single word without numbers, likely natural
                if re.match(r'^[a-zA-Z\s]+$', ingredient) and len(ingredient.split()) <= 2:
                    categories['natural'].append(ingredient)
                else:
                    categories['unknown'].append(ingredient)
        
        return categories
    
    def comprehensive_analysis(self, ingredients_text: str) -> Dict[str, any]:
        """Perform comprehensive ingredient analysis"""
        if not ingredients_text:
            return {
                'error': 'No ingredients text provided',
                'diet_analysis': {},
                'allergen_analysis': {},
                'processing_analysis': {},
                'ingredient_categories': {}
            }
        
        # Extract individual ingredients
        ingredients_list = self.extract_individual_ingredients(ingredients_text)
        
        # Perform all analyses
        diet_analysis = self.determine_diet_type(ingredients_text)
        allergen_analysis = self.detect_allergens(ingredients_text)
        processing_analysis = self.analyze_processing_level(ingredients_list)
        ingredient_categories = self.get_ingredient_categories(ingredients_list)
        
        return {
            'ingredients_count': len(ingredients_list),
            'ingredients_list': ingredients_list,
            'diet_analysis': diet_analysis,
            'allergen_analysis': allergen_analysis,
            'processing_analysis': processing_analysis,
            'ingredient_categories': ingredient_categories,
            'analysis_timestamp': self._get_timestamp()
        }
    
    def _get_timestamp(self) -> str:
        """Get current timestamp"""
        from datetime import datetime
        return datetime.now().isoformat()
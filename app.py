from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import re
import json
import os
from typing import Dict, List, Optional
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter frontend

# Configuration
OPENFOODFACTS_BASE_URL = "https://world.openfoodfacts.org"
USER_AGENT = "Aahar/1.0 (contact@aahar.app)"

# Allergen patterns for detection
ALLERGEN_PATTERNS = {
    'nuts': ['almond', 'walnut', 'pecan', 'cashew', 'pistachio', 'hazelnut', 'brazil nut', 'macadamia', 'pine nut', 'tree nuts', 'nuts', 'groundnut', 'peanut'],
    'dairy': ['milk', 'butter', 'cheese', 'cream', 'yogurt', 'yoghurt', 'whey', 'casein', 'lactose', 'dairy', 'buttermilk', 'ghee', 'paneer', 'curd'],
    'gluten': ['wheat', 'barley', 'rye', 'oats', 'gluten', 'flour', 'malt', 'semolina', 'bulgur', 'spelt'],
    'soy': ['soy', 'soybean', 'tofu', 'tempeh', 'miso', 'edamame', 'soya'],
    'eggs': ['egg', 'albumin', 'lecithin', 'mayonnaise'],
    'fish': ['fish', 'salmon', 'tuna', 'cod', 'sardine', 'anchovy', 'mackerel'],
    'shellfish': ['shrimp', 'crab', 'lobster', 'clam', 'oyster', 'mussel', 'prawn'],
    'sesame': ['sesame', 'tahini', 'sesame oil', 'sesame seeds']
}

# Non-vegetarian ingredients
NON_VEG_INGREDIENTS = [
    'chicken', 'beef', 'pork', 'lamb', 'fish', 'meat', 'gelatin', 'lard',
    'bacon', 'ham', 'pepperoni', 'sausage', 'turkey', 'duck', 'mutton',
    'prawn', 'shrimp', 'crab', 'lobster', 'anchovies', 'tuna', 'salmon'
]

# Non-vegan ingredients (includes non-veg + dairy/eggs)
NON_VEGAN_INGREDIENTS = NON_VEG_INGREDIENTS + [
    'milk', 'butter', 'cheese', 'cream', 'yogurt', 'whey', 'casein',
    'egg', 'honey', 'beeswax', 'albumin', 'ghee', 'paneer', 'curd'
]

# Disease risk ingredients
DISEASE_RISK_INGREDIENTS = {
    'diabetes': ['high fructose corn syrup', 'corn syrup', 'glucose syrup', 'sugar', 'sucrose', 'fructose', 'dextrose'],
    'hypertension': ['salt', 'sodium chloride', 'sodium nitrate', 'msg', 'monosodium glutamate'],
    'cholesterol': ['trans fat', 'partially hydrogenated oil', 'hydrogenated oil', 'saturated fat', 'palm oil'],
    'gluten_intolerance': ['wheat', 'barley', 'rye', 'gluten', 'flour', 'malt'],
    'pregnancy': ['alcohol', 'caffeine', 'raw fish', 'unpasteurized', 'high mercury fish', 'artificial sweeteners']
}

# Mood impact ingredients
MOOD_INGREDIENTS = {
    'energy_boost': ['caffeine', 'coffee', 'tea', 'chocolate', 'cocoa'],
    'sleepy': ['carbohydrates', 'rice', 'pasta', 'bread', 'potato', 'tryptophan'],
    'mood_crash': ['high sugar', 'artificial sweeteners', 'high fructose corn syrup'],
    'calming': ['chamomile', 'lavender', 'magnesium']
}

def get_product_data(barcode: str) -> Optional[Dict]:
    """Fetch basic product data from Open Food Facts API"""
    try:
        url = f"{OPENFOODFACTS_BASE_URL}/api/v2/product/{barcode}"
        headers = {'User-Agent': USER_AGENT}
        
        # Request only needed fields
        params = {
            'fields': 'product_name,brands,categories,ingredients_text,nutriments,quantity'
        }
        
        response = requests.get(url, headers=headers, params=params, timeout=15)
        response.raise_for_status()
        
        data = response.json()
        
        if data.get('status') == 1:
            return data.get('product')
        else:
            return None
            
    except Exception as e:
        logger.error(f"API request error for barcode {barcode}: {e}")
        return None

def analyze_diet_type(ingredients_text: str) -> Dict:
    """Determine if product is vegan, vegetarian, or non-vegetarian"""
    if not ingredients_text:
        return {'diet_type': 'unknown', 'details': []}
    
    ingredients_lower = ingredients_text.lower()
    found_non_veg = []
    found_non_vegan = []
    
    # Check for non-vegetarian ingredients
    for ingredient in NON_VEG_INGREDIENTS:
        if re.search(r'\b' + re.escape(ingredient) + r'\b', ingredients_lower):
            found_non_veg.append(ingredient)
    
    if found_non_veg:
        return {
            'diet_type': 'non-vegetarian',
            'details': found_non_veg
        }
    
    # Check for non-vegan ingredients
    for ingredient in NON_VEGAN_INGREDIENTS:
        if re.search(r'\b' + re.escape(ingredient) + r'\b', ingredients_lower):
            found_non_vegan.append(ingredient)
    
    if found_non_vegan:
        return {
            'diet_type': 'vegetarian',
            'details': found_non_vegan
        }
    
    return {
        'diet_type': 'vegan',
        'details': []
    }

def detect_allergens(ingredients_text: str) -> List[str]:
    """Detect allergens in ingredients"""
    if not ingredients_text:
        return []
    
    ingredients_lower = ingredients_text.lower()
    detected_allergens = []
    
    for allergen_type, patterns in ALLERGEN_PATTERNS.items():
        for pattern in patterns:
            if re.search(r'\b' + re.escape(pattern) + r'\b', ingredients_lower):
                if allergen_type not in detected_allergens:
                    detected_allergens.append(allergen_type)
                break
    
    return detected_allergens

def assess_disease_risks(ingredients_text: str) -> Dict:
    """Check for ingredients that may affect common health conditions"""
    if not ingredients_text:
        return {}
    
    ingredients_lower = ingredients_text.lower()
    risks = {}
    
    for condition, risk_ingredients in DISEASE_RISK_INGREDIENTS.items():
        found_risks = []
        for ingredient in risk_ingredients:
            if re.search(r'\b' + re.escape(ingredient) + r'\b', ingredients_lower):
                found_risks.append(ingredient)
        
        if found_risks:
            risks[condition] = found_risks
    
    return risks

def predict_mood_impact(ingredients_text: str, nutriments: Dict) -> Dict:
    """Predict mood impact based on ingredients and nutrients"""
    if not ingredients_text:
        return {'mood_effects': [], 'description': 'No mood impact predicted'}
    
    ingredients_lower = ingredients_text.lower()
    mood_effects = []
    
    # Check ingredients for mood effects
    for mood_type, mood_ingredients in MOOD_INGREDIENTS.items():
        for ingredient in mood_ingredients:
            if re.search(r'\b' + re.escape(ingredient) + r'\b', ingredients_lower):
                mood_effects.append(mood_type)
                break
    
    # Check sugar content for mood effects
    try:
        sugars = float(nutriments.get('sugars_100g', 0) or 0)
        if sugars > 15:
            mood_effects.append('energy_spike_then_crash')
        elif sugars > 8:
            mood_effects.append('mild_energy_boost')
    except:
        pass
    
    # Generate description
    descriptions = {
        'energy_boost': 'May increase alertness and energy',
        'sleepy': 'May promote relaxation and sleepiness',
        'mood_crash': 'May cause energy dips',
        'calming': 'May have calming effects',
        'energy_spike_then_crash': 'High sugar may cause energy spike followed by crash',
        'mild_energy_boost': 'May provide mild energy boost'
    }
    
    if mood_effects:
        description = '; '.join([descriptions.get(effect, effect) for effect in mood_effects])
    else:
        description = 'No significant mood impact expected'
    
    return {
        'mood_effects': mood_effects,
        'description': description
    }

def format_nutrient_content(nutriments: Dict) -> Dict:
    """Format nutrient content per 100g in a simple way"""
    nutrients = {}
    
    # Key nutrients to display
    nutrient_map = {
        'energy-kcal_100g': 'Energy (kcal)',
        'proteins_100g': 'Protein (g)',
        'carbohydrates_100g': 'Carbohydrates (g)',
        'sugars_100g': 'Sugars (g)',
        'fat_100g': 'Fat (g)',
        'saturated-fat_100g': 'Saturated Fat (g)',
        'fiber_100g': 'Fiber (g)',
        'sodium_100g': 'Sodium (mg)',
        'salt_100g': 'Salt (g)'
    }
    
    for key, display_name in nutrient_map.items():
        value = nutriments.get(key)
        if value is not None:
            try:
                # Convert to float and round to 1 decimal place
                nutrients[display_name] = round(float(value), 1)
            except:
                pass
    
    return nutrients

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy', 
        'message': 'Aahar API is running!',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/product/<barcode>', methods=['GET'])
def get_product_info(barcode):
    """Main endpoint to get product information"""
    try:
        # Validate barcode
        if not barcode or not re.match(r'^\d{8,14}$', barcode):
            return jsonify({'error': 'Invalid barcode format'}), 400
        
        logger.info(f"Processing barcode: {barcode}")
        
        # Fetch product data
        product_data = get_product_data(barcode)
        
        if not product_data:
            return jsonify({
                'error': 'Product not found',
                'barcode': barcode,
                'found': False
            }), 404
        
        # Extract basic information
        product_name = product_data.get('product_name', 'Unknown Product')
        brand = product_data.get('brands', 'Unknown Brand')
        category = product_data.get('categories', '').split(',')[0] if product_data.get('categories') else 'Unknown Category'
        ingredients_text = product_data.get('ingredients_text', '')
        quantity = product_data.get('quantity', '')
        nutriments = product_data.get('nutriments', {})
        
        # Perform analysis
        diet_analysis = analyze_diet_type(ingredients_text)
        allergens = detect_allergens(ingredients_text)
        disease_risks = assess_disease_risks(ingredients_text)
        mood_prediction = predict_mood_impact(ingredients_text, nutriments)
        nutrient_content = format_nutrient_content(nutriments)
        
        # Create simplified response
        response = {
            'barcode': barcode,
            'found': True,
            'basic_info': {
                'product_name': product_name,
                'brand': brand,
                'category': category.strip(),
                'quantity': quantity
            },
            'ingredients': {
                'full_list': ingredients_text,
                'ingredients_array': [ing.strip() for ing in ingredients_text.split(',') if ing.strip()] if ingredients_text else []
            },
            'nutrient_content_per_100g': nutrient_content,
            'diet_check': {
                'diet_type': diet_analysis['diet_type'],
                'is_vegan': diet_analysis['diet_type'] == 'vegan',
                'is_vegetarian': diet_analysis['diet_type'] in ['vegan', 'vegetarian'],
                'non_compliant_ingredients': diet_analysis['details']
            },
            'allergen_check': {
                'contains_allergens': len(allergens) > 0,
                'allergens_found': allergens,
                'allergen_count': len(allergens)
            },
            'disease_risk_assessment': {
                'has_risks': len(disease_risks) > 0,
                'risk_categories': list(disease_risks.keys()),
                'risk_details': disease_risks
            },
            'mood_prediction': mood_prediction,
            'analysis_timestamp': datetime.now().isoformat()
        }
        
        logger.info(f"Successfully analyzed: {product_name}")
        return jsonify(response)
        
    except Exception as e:
        logger.error(f"Error processing barcode {barcode}: {str(e)}")
        return jsonify({
            'error': 'Internal server error',
            'barcode': barcode
        }), 500

@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Endpoint not found'}), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('FLASK_ENV') == 'development'
    
    logger.info(f"Starting Aahar API server on port {port}")
    app.run(debug=debug, host='0.0.0.0', port=port)

@app.route('/search')
def search():
    query = request.args.get('q')
    return jsonify({"message": f"Search received for '{query}'"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('FLASK_ENV') == 'development'
    logger.info(f"Starting Aahar API server on port {port}")
    app.run(debug=debug, host='0.0.0.0', port=port)

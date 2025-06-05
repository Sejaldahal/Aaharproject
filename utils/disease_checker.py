import re
from typing import Dict, List

# Disease risk ingredient mappings
DISEASE_INGREDIENT_MAP = {
    'diabetes': [
        'high fructose corn syrup', 'corn syrup', 'glucose syrup', 
        'sugar', 'sucrose', 'fructose', 'dextrose', 'maltose',
        'brown sugar', 'cane sugar', 'refined sugar'
    ],
    'hypertension': [
        'salt', 'sodium chloride', 'sodium nitrate', 'sodium nitrite',
        'msg', 'monosodium glutamate', 'sodium benzoate', 'baking soda'
    ],
    'cholesterol': [
        'trans fat', 'partially hydrogenated oil', 'hydrogenated oil',
        'saturated fat', 'palm oil', 'coconut oil', 'lard', 'shortening'
    ],
    'gluten_intolerance': [
        'wheat', 'barley', 'rye', 'gluten', 'wheat flour', 'all purpose flour',
        'bread flour', 'malt', 'semolina', 'bulgur', 'spelt'
    ],
    'pregnancy': [
        'alcohol', 'caffeine', 'raw fish', 'unpasteurized cheese',
        'unpasteurized milk', 'artificial sweeteners', 'high mercury fish',
        'raw meat', 'raw eggs'
    ]
}

def check_disease_risks(ingredients_text: str, specific_conditions: List[str] = None) -> Dict[str, List[str]]:
    """
    Check ingredients for potential health risks
    
    Args:
        ingredients_text: String of ingredients to analyze
        specific_conditions: List of conditions to check for (optional)
    
    Returns:
        Dictionary mapping conditions to list of risky ingredients found
    """
    if not ingredients_text:
        return {}
    
    ingredients_lower = ingredients_text.lower()
    risk_results = {}
    
    # Use all conditions if none specified
    conditions_to_check = specific_conditions or list(DISEASE_INGREDIENT_MAP.keys())
    
    for condition in conditions_to_check:
        if condition not in DISEASE_INGREDIENT_MAP:
            continue
            
        risky_ingredients = DISEASE_INGREDIENT_MAP[condition]
        found_risks = []
        
        for ingredient in risky_ingredients:
            # Use word boundary matching for better accuracy
            if re.search(r'\b' + re.escape(ingredient) + r'\b', ingredients_lower):
                found_risks.append(ingredient)
        
        if found_risks:
            risk_results[condition] = found_risks
    
    return risk_results

def get_condition_advice(condition: str, found_ingredients: List[str]) -> str:
    """
    Get advice for specific health conditions
    
    Args:
        condition: Health condition name
        found_ingredients: List of risky ingredients found
    
    Returns:
        Advice string for the condition
    """
    advice_map = {
        'diabetes': f"Contains {', '.join(found_ingredients)} which may cause blood sugar spikes. Monitor your glucose levels.",
        'hypertension': f"High in {', '.join(found_ingredients)} which may increase blood pressure. Limit sodium intake.",
        'cholesterol': f"Contains {', '.join(found_ingredients)} which may affect cholesterol levels. Choose heart-healthy alternatives.",
        'gluten_intolerance': f"Contains {', '.join(found_ingredients)} which contain gluten. Not suitable for celiac or gluten-sensitive individuals.",
        'pregnancy': f"Contains {', '.join(found_ingredients)} which may not be safe during pregnancy. Consult your doctor."
    }
    
    return advice_map.get(condition, f"Contains ingredients that may affect {condition}")

def analyze_ingredient_risks(ingredients_text: str, user_conditions: List[str] = None) -> Dict:
    """
    Comprehensive analysis of ingredient risks for health conditions
    
    Args:
        ingredients_text: String of ingredients to analyze
        user_conditions: List of user's health conditions
    
    Returns:
        Detailed risk analysis
    """
    if not ingredients_text:
        return {
            'has_risks': False,
            'risk_count': 0,
            'risks': {},
            'advice': []
        }
    
    # Check for risks
    risks = check_disease_risks(ingredients_text, user_conditions)
    
    # Generate advice
    advice = []
    for condition, ingredients in risks.items():
        advice.append(get_condition_advice(condition, ingredients))
    
    return {
        'has_risks': len(risks) > 0,
        'risk_count': len(risks),
        'risks': risks,
        'advice': advice,
        'conditions_checked': user_conditions or list(DISEASE_INGREDIENT_MAP.keys())
    }
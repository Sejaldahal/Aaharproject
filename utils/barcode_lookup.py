#barcode_lookup.py content
import requests
import logging
from typing import Dict, Optional, List
import time

logger = logging.getLogger(__name__)

class OpenFoodFactsAPI:
    """Handle all OpenFoodFacts API interactions"""
    
    def __init__(self):
        self.base_url = "https://world.openfoodfacts.org"
        self.user_agent = "Aahar/1.0 (contact@aahar.app)"
        self.session = requests.Session()
        self.session.headers.update({'User-Agent': self.user_agent})
        
    def get_product(self, barcode: str, fields: Optional[List[str]] = None) -> Optional[Dict]:
        """
        Fetch product data from OpenFoodFacts API
        
        Args:
            barcode: Product barcode
            fields: Specific fields to retrieve (optional)
            
        Returns:
            Product data dictionary or None if not found
        """
        try:
            url = f"{self.base_url}/api/v2/product/{barcode}"
            
            # Default fields if none specified
            if fields is None:
                fields = [
                    'product_name', 'ingredients_text', 'ingredients', 'allergens',
                    'nutrition_grades', 'nutriments', 'categories', 'labels',
                    'additives_tags', 'nova_group', 'ecoscore_grade', 'nutriscore_grade',
                    'brands', 'quantity', 'packaging', 'manufacturing_places',
                    'origins', 'stores', 'image_url', 'image_front_url'
                ]
            
            params = {'fields': ','.join(fields)}
            
            response = self.session.get(url, params=params, timeout=15)
            response.raise_for_status()
            
            data = response.json()
            
            if data.get('status') == 1:
                product = data.get('product', {})
                logger.info(f"Successfully fetched product: {barcode}")
                return product
            else:
                logger.warning(f"Product not found: {barcode}")
                return None
                
        except requests.exceptions.Timeout:
            logger.error(f"Timeout while fetching product: {barcode}")
            return None
        except requests.exceptions.RequestException as e:
            logger.error(f"Request error for barcode {barcode}: {e}")
            return None
        except Exception as e:
            logger.error(f"Unexpected error for barcode {barcode}: {e}")
            return None
    
    def search_products(self, query: str = "", category: str = "", nutrition_grade: str = "", 
                       page: int = 1, page_size: int = 20) -> Optional[Dict]:
        """
        Search products in OpenFoodFacts database
        
        Args:
            query: Search term
            category: Product category
            nutrition_grade: Nutrition grade filter (a, b, c, d, e)
            page: Page number
            page_size: Results per page
            
        Returns:
            Search results dictionary or None if error
        """
        try:
            url = f"{self.base_url}/api/v2/search"
            
            params = {
                'page': page,
                'page_size': min(page_size, 50),  # Limit max page size
                'fields': 'code,product_name,nutrition_grades,categories,brands,quantity,image_url'
            }
            
            if query:
                params['search_terms'] = query
            if category:
                params['categories_tags_en'] = category
            if nutrition_grade:
                params['nutrition_grades_tags'] = nutrition_grade
            
            response = self.session.get(url, params=params, timeout=15)
            response.raise_for_status()
            
            return response.json()
            
        except requests.exceptions.RequestException as e:
            logger.error(f"Search API error: {e}")
            return None
        except Exception as e:
            logger.error(f"Unexpected search error: {e}")
            return None
    
    def get_product_suggestions(self, partial_barcode: str) -> List[Dict]:
        """
        Get product suggestions based on partial barcode
        
        Args:
            partial_barcode: Partial barcode string
            
        Returns:
            List of suggested products
        """
        try:
            if len(partial_barcode) < 4:
                return []
            
            # Search for products with similar barcodes
            url = f"{self.base_url}/api/v2/search"
            params = {
                'search_terms': partial_barcode,
                'page_size': 10,
                'fields': 'code,product_name,brands'
            }
            
            response = self.session.get(url, params=params, timeout=10)
            response.raise_for_status()
            
            data = response.json()
            suggestions = []
            
            for product in data.get('products', []):
                barcode = product.get('code', '')
                if barcode.startswith(partial_barcode):
                    suggestions.append({
                        'barcode': barcode,
                        'name': product.get('product_name', 'Unknown'),
                        'brand': product.get('brands', '')
                    })
            
            return suggestions[:5]  # Return top 5 suggestions
            
        except Exception as e:
            logger.error(f"Error getting suggestions for {partial_barcode}: {e}")
            return []
    
    def validate_barcode(self, barcode: str) -> Dict[str, any]:
        """
        Validate barcode format and check if product exists
        
        Args:
            barcode: Barcode string to validate
            
        Returns:
            Validation result dictionary
        """
        result = {
            'is_valid': False,
            'format_valid': False,
            'exists': False,
            'error': None
        }
        
        try:
            # Check format - should be 8-14 digits
            if not barcode.isdigit():
                result['error'] = 'Barcode must contain only digits'
                return result
            
            if len(barcode) < 8 or len(barcode) > 14:
                result['error'] = 'Barcode must be 8-14 digits long'
                return result
            
            result['format_valid'] = True
            
            # Quick check if product exists (minimal data fetch)
            product = self.get_product(barcode, fields=['product_name'])
            if product:
                result['exists'] = True
                result['is_valid'] = True
            else:
                result['error'] = 'Product not found in database'
            
        except Exception as e:
            result['error'] = f'Validation error: {str(e)}'
            logger.error(f"Barcode validation error: {e}")
        
        return result
    
    def get_popular_categories(self) -> List[str]:
        """Get list of popular food categories"""
        return [
            "beverages",
            "snacks", 
            "dairy",
            "cereals-and-breakfast",
            "frozen-foods",
            "canned-foods",
            "bread",
            "chocolate",
            "biscuits-and-cakes",
            "meat",
            "fish",
            "fruits-and-vegetables",
            "condiments",
            "desserts",
            "baby-foods",
            "breakfast-cereals",
            "yogurts",
            "cheeses",
            "plant-based-foods",
            "organic-products"
        ]
    
    def get_batch_products(self, barcodes: List[str]) -> Dict[str, Optional[Dict]]:
        """
        Fetch multiple products in batch (for efficiency)
        
        Args:
            barcodes: List of barcodes to fetch
            
        Returns:
            Dictionary mapping barcodes to product data
        """
        results = {}
        
        for barcode in barcodes:
            # Add small delay to respect API rate limits
            time.sleep(0.1)
            product = self.get_product(barcode)
            results[barcode] = product
            
        return results
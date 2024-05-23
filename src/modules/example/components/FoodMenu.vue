<template>
    <div class="category">
        <h3>{{ category }}</h3>
    </div>
    <div class="list-food">
        <Food
            v-for="(food, index) in listFood"
            :key="index"
            :imgLink="food.foodImg?.url"
            :name="food.name"
            :price="food.price"
        />
    </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import CompIcon from '../../../components/CompIcon.vue';
import Food from './Food.vue';

@Options({
    name: 'product-table-component',
    components: {
        CompIcon,
        Food,
    },
    props: {
        listFood: {
            type: Array,
        },
        category: {
            type: String,
        },
    },
})
export default class FoodMenu extends Vue {}
</script>

<style lang="scss" scoped>
.list-food {
    width: 100%;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-between;
}
</style>
